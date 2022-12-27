locals {
  original_tags    = join(var.delimiter, compact(concat(tolist([var.namespace, var.stage, var.name]), var.attributes)))
  transformed_tags = var.convert_case ? lower(local.original_tags) : local.original_tags

  id = var.enabled ? local.transformed_tags : ""

  name       = var.enabled ? (var.convert_case ? lower(format("%v", var.name)) : format("%v", var.name)) : ""
  stage      = var.enabled ? (var.convert_case ? lower(format("%v", var.stage)) : format("%v", var.stage)) : ""
  namespace  = var.enabled ? (var.convert_case ? lower(format("%v", var.namespace)) : format("%v", var.namespace)) : ""
  delimiter  = var.enabled ? (var.convert_case ? lower(format("%v", var.delimiter)) : format("%v", var.delimiter)) : ""
  attributes = var.enabled ? (var.convert_case ? lower(format("%v", join(var.delimiter, compact(var.attributes)))) : format("%v", join(var.delimiter, compact(var.attributes)))) : ""

  tags = merge(
    {
      "Name"      = local.id
      "Stage"     = local.stage
      "Namespace" = local.namespace
    },
    var.tags
  )
}
