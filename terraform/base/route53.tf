# Route 53 resources

resource "aws_route53_zone" "moztools" {
    name = "moz.tools."
}

################
##  moz.tools ##
################

resource "aws_route53_record" "relman-ci-moz-tools-cname-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "relman-ci.moz.tools"
  type = "A"
  ttl = "180"
  records = ["35.180.7.143"]
}

resource "aws_route53_record" "relman-clouseau-moz-tools-cname-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "clouseau.moz.tools"
  type = "CNAME"
  ttl = "180"
  records = ["clouseau.moz.tools.herokudns.com"]
}

resource "aws_route53_record" "relman-buildhub-moz-tools-cname-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "buildhub.moz.tools"
  type = "CNAME"
  ttl = "180"
  records = ["prod.buildhub2.prod.cloudops.mozgcp.net"]
}

resource "aws_route53_record" "relman-buildhub-moz-tools-cert-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "_1cd7d55cbecc43cd936b8a83293e002d.buildhub.moz.tools"
  type = "CNAME"
  ttl = "180"
  records = ["dcv.digicert.com"]
}

resource "aws_route53_record" "relman-coverity-moz-tools-cname-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "coverity.moz.tools"
  type = "CNAME"
  ttl = "180"
  records = ["prod.coverity.prod.cloudops.mozgcp.net"]
}

resource "aws_route53_record" "relman-coverage-moz-tools-ns-prod" {
  zone_id = "${aws_route53_zone.moztools.zone_id}"
  name = "coverage.moz.tools"
  type = "NS"
  ttl = "180"
  records = [
    "ns-1151.awsdns-15.org.",
    "ns-584.awsdns-09.net.",
    "ns-1748.awsdns-26.co.uk.",
    "ns-60.awsdns-07.com.",
  ]
}

###################
## Code Coverage ##
###################

resource "aws_route53_record" "heroku-code-coverage-backend-shipit-cname-prod" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "api.coverage.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["desolate-artichoke-1kra3z6kgs9mw2sa15u9abte.herokudns.com"]
}

resource "aws_route53_record" "heroku-code-coverage-backend-shipit-cname-test" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "api.coverage.testing.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["quiet-elk-4brvoeg6xv0mahvfwgtnveu6.herokudns.com"]
}

#################
## Code review ##
#################


# TODO: remove once switch to code-review.moz.tools is complete
resource "aws_route53_record" "heroku-event-listener-cname-prod" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "eventlistener.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["convex-woodland-ilwk96s11s92e5otfkmb5ybe.herokudns.com"]
}

# TODO: remove once switch to code-review.testing.moz.tools is complete
resource "aws_route53_record" "heroku-event-listener-cname-test" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "eventlistener.testing.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["adjacent-shelf-2mxct7inb0tl5tg1rwt73ev4.herokudns.com"]
}

resource "aws_route53_record" "heroku-event-code-review-cname-prod" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "events.code-review.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["computational-tulip-1uri1v0f5lt15a7auezt7p5o.herokudns.com"]
}

resource "aws_route53_record" "heroku-event-code-review-cname-test" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "events.code-review.testing.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["convex-raven-uc9qj36u74ermlf6qiz8fgsc.herokudns.com"]
}

resource "aws_route53_record" "heroku-backend-code-review-cname-prod" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "api.code-review.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["mysterious-mullberry-o1x86tkb7po3dvawe5tm1yxf.herokudns.com"]
}

resource "aws_route53_record" "heroku-backend-code-review-cname-test" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "api.code-review.testing.moz.tools"
    type = "CNAME"
    ttl = "180"
    records = ["polar-leopard-oghlp6pg2r3w8s766swnec7j.herokudns.com"]
}



############################
## CloudFront CDN aliases ##
############################

variable "cloudfront_moztools_alias" {
    default = ["code-review",
               "code-review.testing"]
}

variable "cloudfront_moztools_alias_domain" {
    type = "map"
    default = {
        code-review = "d2ezri92497z3m"
        code-review.testing = "d1blqs705aw8h9"
    }
}

resource "aws_route53_record" "cloudfront-moztools-alias" {
    zone_id = "${aws_route53_zone.moztools.zone_id}"
    name = "${element(var.cloudfront_moztools_alias, count.index)}.moz.tools"
    type = "A"
    count = "${length(var.cloudfront_moztools_alias)}"

    alias {
        name = "${var.cloudfront_moztools_alias_domain[element(var.cloudfront_moztools_alias, count.index)]}.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
}
