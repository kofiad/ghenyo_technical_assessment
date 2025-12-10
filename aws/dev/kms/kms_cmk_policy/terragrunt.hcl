include "root" {
    path = find_in_parent_folders()
}

terraform {
    source = "../../../../../modules/kms_cmk_policy"
}

dependency "kms" {
    config_path = "../kms_cmk"
}

inputs = {
    kms_key_id = dependency.kms.outputs.kms_key_id
    environment = "dev"
}