include "root"{
    path = find_in_parent_folders()
}

terraform {
	source = "../../../../modules/kms_cmk"
}

inputs = {
    description = "cmk for ghenyo ta"
    deletion_window_in_days = 7
    alias_name = "ghenyo_ta_kms"
    enable_key_rotation = true
}