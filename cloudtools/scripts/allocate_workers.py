import random
import argparse
import json

from cloudtools.aws import get_available_ips
from cloudtools import infoblox


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--config", required=True,
                        type=argparse.FileType('r'),
                        help="instance configuration to use")
    parser.add_argument("-n", "--number", type=int, required=True,
                        help="How many workers you need")
    parser.add_argument("-p", "--prefix", type=str, required=True,
                        help="The DNS name prefix")
    parser.add_argument("-o", "--output", type=str, required=True,
                        help="The base name of the files with DNS entries to create")
    args = parser.parse_args()

    try:
        config = json.load(args.config)
    except KeyError:
        parser.error("unknown configuration")

    regions = sorted(config.keys())

    available_ips = {}
    for region in regions:
        available_ips[region] = get_available_ips(region, config[region])
        random.shuffle(available_ips[region])

    hosts = {}
    cnames = {}
    for i in range(1, args.number+1):
        hostname = '{}-{}'.format(args.prefix, i)
        region = regions[(i-1) % len(regions)]
        fqdn = '{}.{}'.format(hostname, config[region]['domain'])
        cname = '{}.build.mozilla.org'.format(hostname, config[region]['domain'])
        hosts[fqdn] = available_ips[region].pop()
        cnames[cname] = fqdn

    with open('{}.cnames.csv'.format(args.output), 'w') as f:
        infoblox.write_cnames(f, cnames)

    with open('{}.a.csv'.format(args.output), 'w') as f:
        infoblox.write_a(f, hosts)

    with open('{}.ptr.csv'.format(args.output), 'w') as f:
        infoblox.write_ptr(f, hosts)


if __name__ == "__main__":
    main()
