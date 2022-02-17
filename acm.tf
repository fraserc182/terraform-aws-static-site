resource "aws_acm_certificate" "ssl" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

resource "aws_route53_record" "validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "ssl_validate" {
  certificate_arn         = aws_acm_certificate.ssl.arn
  validation_record_fqdns = [for record in aws_route53_record.ssl : record.fqdn]
}