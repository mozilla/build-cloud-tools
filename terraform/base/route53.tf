
######################################################################
#                                                                    #
# IMPORTANT: mozilla-releng.net resources were generated, do not     #
#            change them manually!                                   #
#                                                                    #
#     https://docs.mozilla-releng.net/deploy/configure-dns.html      #
#                                                                    #
######################################################################

resource "aws_route53_zone" "mozilla-releng" {
    name = "mozilla-releng.net."
}

# A special root alias that points to www.mozilla-releng.net
resource "aws_route53_record" "root-alias" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "mozilla-releng.net"
    type = "A"

    alias {
        name = "www.mozilla-releng.net"
        zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "heroku-coalease-cname" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "coalesce.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["oita-54541.herokussl.com"]
}


resource "aws_route53_record" "heroku-archiver-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "archiver.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["archiver.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-clobberer-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "clobberer.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["saitama-70467.herokussl.com"]
}


resource "aws_route53_record" "heroku-docs-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "docs.mozilla-releng.net"
    type = "A"
    alias {
        name = "d1945er7u4liht.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-docs-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "docs.staging.mozilla-releng.net"
    type = "A"
    alias {
        name = "d32jt14rospqzr.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-frontend-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "mozilla-releng.net"
    type = "A"
    alias {
        name = "d1qqwps52z1e12.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-frontend-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "staging.mozilla-releng.net"
    type = "A"
    alias {
        name = "dpwmwa9tge2p3.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-mapper-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "mapper.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["mapper.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-notification-identity-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "identity.notification.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["identity.notification..mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-notification-identity-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "identity.notification.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["identity.notification.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-notification-policy-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "policy.notification.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["policy.notification..mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-notification-policy-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "policy.notification.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["policy.notification.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-tooltool-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "tooltool.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["kochi-11433.herokussl.com"]
}


resource "aws_route53_record" "heroku-tooltool-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "tooltool.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["shizuoka-60622.herokussl.com"]
}


resource "aws_route53_record" "heroku-treestatus-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "treestatus.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["kochi-31413.herokussl.com"]
}


resource "aws_route53_record" "heroku-treestatus-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "treestatus.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["treestatus.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-frontend-shipit-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "shipit.mozilla-releng.net"
    type = "A"
    alias {
        name = "dve8yd1431ifz.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-frontend-shipit-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "shipit.staging.mozilla-releng.net"
    type = "A"
    alias {
        name = "d2ld4e8bl8yd1l.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}


resource "aws_route53_record" "heroku-pipeline-shipit-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "pipeline.shipit.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["pipeline.shipit.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-signoff-shipit-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "signoff.shipit.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["signoff.shipit.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-taskcluster-shipit-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "taskcluster.shipit.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["taskcluster.shipit.staging.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-uplift-shipit-cname-prod" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "uplift.shipit.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["uplift.shipit.mozilla-releng.net.herokudns.com"]
}


resource "aws_route53_record" "heroku-uplift-shipit-cname-stage" {
    zone_id = "${aws_route53_zone.mozilla-releng.zone_id}"
    name = "uplift.shipit.staging.mozilla-releng.net"
    type = "CNAME"
    ttl = "180"
    records = ["uplift.shipit.staging.mozilla-releng.net.herokudns.com"]
}

