include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

inputs = {
  bucket_name = "my-company-backups-${local.environment}-${formatdate("YYYYMMDD", timestamp())}"
}