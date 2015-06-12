import logging
from collections import defaultdict

from repoze.lru import lru_cache

from cloudtools.utils import get_json


SLAVES_JSON_URL = "http://slavealloc.pvt.build.mozilla.org/api/slaves"
CACHE_FILE = "slaves.json"
CACHE_TTL = 10 * 60

log = logging.getLogger(__name__)


@lru_cache(10)
def get_classified_slaves(is_spot=True):
    js = get_json(SLAVES_JSON_URL, CACHE_FILE)
    slaves = [s for s in js if is_spot_slave(s) is is_spot and is_enabled(s)]
    # 2D dict: x[moz_type][region] = ["slave1", "slave2"]
    classified_slaves = defaultdict(lambda: defaultdict(set))
    for s in slaves:
        moz_type = slave_moz_type(s)
        region = slave_region(s)
        name = s.get("name")
        if all([moz_type, region, name]):
            classified_slaves[moz_type][region].add(name)
    return classified_slaves


def slave_region(slave):
    return slave.get("datacenter")


def is_spot_slave(slave):
    return "-spot-" in slave.get("name", "")


def is_enabled(slave):
    return slave.get("enabled")


def slave_moz_type(slave):
    # Separate golden slaves
    if slave.get("name") and "golden" in slave.get("name"):
        return "golden"

    # bld-linux64
    if slave.get("bitlength") == "64" and \
       slave.get("environment") == "prod" and \
       slave.get("distro") == "centos6-mock" and \
       slave.get("purpose") == "build" and \
       slave.get("trustlevel") == "core":
        return "bld-linux64"

    # try-linux64
    if slave.get("bitlength") == "64" and \
       slave.get("environment") == "prod" and \
       slave.get("distro") == "centos6-mock" and \
       slave.get("purpose") == "build" and \
       slave.get("trustlevel") == "try":
        return "try-linux64"

    # tst-linux32
    if slave.get("bitlength") == "32" and \
       slave.get("environment") == "prod" and \
       slave.get("distro") == "ubuntu32" and \
       slave.get("purpose") == "tests" and \
       slave.get("trustlevel") == "try":
        return "tst-linux32"

    # tst-linux64
    if slave.get("bitlength") == "64" and \
       slave.get("environment") == "prod" and \
       slave.get("distro") == "ubuntu64" and \
       slave.get("purpose") == "tests" and \
       slave.get("speed") == "m1.medium" and \
       slave.get("trustlevel") == "try":
        return "tst-linux64"

    # tst-emulator64
    if slave.get("bitlength") == "64" and \
       slave.get("environment") == "prod" and \
       slave.get("distro") == "ubuntu64" and \
       slave.get("purpose") == "tests" and \
       slave.get("speed") == "c3.xlarge" and \
       slave.get("trustlevel") == "try":
        return "tst-emulator64"

    return None
