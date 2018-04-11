import random
import argparse
import json

from cloudtools.aws import get_available_ips


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--config", required=True,
                        type=argparse.FileType('r'),
                        help="instance configuration to use")
    parser.add_argument("-r", "--region", help="region to use",
                        default="us-east-1")
    parser.add_argument("-n", "--number", type=int, required=True,
                        help="How many IPs you need")
    args = parser.parse_args()

    try:
        config = json.load(args.config)[args.region]
    except KeyError:
        parser.error("unknown configuration")

    available_ips = get_available_ips(args.region, config)

    sample = random.sample(available_ips, args.number)
    for ip in sample:
        print ip


if __name__ == "__main__":
    main()
