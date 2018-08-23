import csv

_CNAME_FIELDS = [
    'header-cnamerecord',
    'fqdn*',
    '_new_fqdn',
    'canonical_name',
    'comment',
    'creator',
    'ddns_principal',
    'ddns_protected',
    'disabled',
    'ttl',
    'view',
]

_A_FIELDS = [
    'header-hostrecord',
    'fqdn*',
    '_new_fqdn',
    'addresses',
    'aliases',
    'cli_credentials',
    'comment',
    'configure_for_dns',
    '_new_configure_for_dns',
    'created_timestamp',
    'creator_member',
    'ddns_protected',
    'disabled',
    'enable_discovery',
    'enable_immediate_discovery',
    'ipv6_addresses',
    'network_view',
    'override_cli_credentials',
    'override_credential',
    'snmpv1v2_credential',
    'snmpv3_credential',
    'ttl',
    'use_snmpv3_credential',
    'view',
    'EA-Asset_Tag',
    'EA-NAT-MAPPING',
    'EA-PDU',
    'EA-Serial'
]

_PTR_FIELDS = [
    'header-hostaddress',
    'address*',
    '_new_address',
    'parent*',
    'boot_file',
    'boot_server',
    'broadcast_address',
    'configure_for_dhcp',
    'configure_for_dns',
    'deny_bootp',
    'domain_name',
    'domain_name_servers',
    'ignore_dhcp_param_request_list',
    'lease_time',
    'mac_address',
    'match_option',
    'network_view',
    'next_server',
    'option_logic_filters',
    'pxe_lease_time',
    'pxe_lease_time_enabled',
    'routers',
    'use_for_ea_inheritance',
    'view'
]


def write_files(file, cnames, hosts):
    cname_writer = csv.DictWriter(file, fieldnames=_CNAME_FIELDS, lineterminator='\n')
    cname_writer.writeheader()
    a_writer = csv.DictWriter(file, fieldnames=_A_FIELDS, lineterminator='\n')
    a_writer.writeheader()
    ptr_writer = csv.DictWriter(file, fieldnames=_PTR_FIELDS, lineterminator='\n')
    ptr_writer.writeheader()

    for cname, target in cnames.items():
        cname_writer.writerow({
            'header-cnamerecord': 'cnamerecord',
            'fqdn*': cname,
            'canonical_name': target,
            'creator': 'STATIC',
            'ddns_protected': 'FALSE',
            'disabled': 'FALSE',
            'view': 'Private',
        })
    for name, ip in hosts.items():
        a_writer.writerow({
            'header-hostrecord': 'hostrecord',
            'fqdn*': name,
            'addresses': ip,
            'configure_for_dns': True,
            'ddns_protected': False,
            'disabled': False,
            'enable_discovery': True,
            'enable_immediate_discovery': False,
            'network_view': 'Mozilla',
            'override_cli_credentials': False,
            'override_credential': False,
            'use_snmpv3_credential': False,
            'view': 'Private',
        })
        ptr_writer.writerow({
            'header-hostaddress': 'hostaddress',
            'address*': ip,
            'parent*': name,
            'configure_for_dhcp': False,
            'configure_for_dns': True,
            'network_view': 'Mozilla',
            'use_for_ea_inheritance': False,
            'view': 'Private',
        })
