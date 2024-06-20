locals {
  original_map = {
    key1 = {
      attr1 = "value1"
      attr2 = "value2"
    }
    key2 = {
      attr1 = "value3"
      attr2 = "value4"
    }
  }
  update_map = {
    for k, v in local.original_map : k => merge(
      v,
      {
        attr3 = "value5"
      }
    ) if v.attr1 == "value1"
  }
  combined_map = merge(local.original_map, local.update_map)
}

output "output_map" {
  value = local.combined_map
}