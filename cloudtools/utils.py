import os
import time
import json
import logging
import tempfile
import shutil

import requests

CACHE_TTL = 10 * 60  # 10 minutes

log = logging.getLogger(__name__)


def get_json(url, cache, ttl=CACHE_TTL):
    """
    Returns the parsed JSON from url, using a local cache
    """
    try:
        mtime = os.stat(cache).st_mtime
        now = time.time()
        if now - mtime < CACHE_TTL:
            log.debug("Using cached file %s", cache)
            return read_json(cache)
        else:
            log.debug("File expired, fetching a new one")
    except (OSError, IOError, KeyError):
        log.warn("Error reading cache file, trying to fetch", exc_info=True)

    try:
        download_file(url, cache)
    except:
        log.warn("Cannot fetch %s, reusing the existing file", url,
                 exc_info=True)
    return read_json(cache)


def read_json(filename):
    return json.load(open(filename))


def download_file(url, dest):
    req = requests.get(url, timeout=30)
    req.raise_for_status()
    _, tmp_fname = tempfile.mkstemp()
    with open(tmp_fname, "wb") as f:
        f.write(req.content)
    log.debug("moving %s to %s", tmp_fname, dest)
    shutil.move(tmp_fname, dest)
