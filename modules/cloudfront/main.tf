resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.name
  description                       = var.description
  origin_access_control_origin_type = var.origin_access_control_origin_type
  signing_behavior                  = var.signing_behavior
  signing_protocol                  = var.signing_protocol
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_id                = var.bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }
  
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  
  default_cache_behavior {
    target_origin_id       = var.bucket_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    compress               = true
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

