resource "aws_instance" "ec2instance" {
  ami                     = var.ami_id
  instance_type           = var.ec2_instance_size
  key_name                = var.ec2_key_name == "" ? null : var.ec2_key_name
  subnet_id               = var.subnetid
  vpc_security_group_ids  = var.security_group_id
  iam_instance_profile    = local.instance_profile
  private_ip              = var.private_ip
  disable_api_termination = var.disable_api_termination
  ebs_optimized           = var.ebs_optimized

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    iops                  = var.root_volume_iops
    throughput            = var.root_volume_throughput
    delete_on_termination = true
    encrypted             = true
    kms_key_id            = var.kms_key_arn
  }

  dynamic "ebs_block_device" {
    for_each = { for vol in var.ebs_block_device : index(var.ebs_block_device, vol) => vol }
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.size
      volume_type           = ebs_block_device.value.type
      delete_on_termination = ebs_block_device.value.delete_on_termination
      throughput            = lookup(ebs_block_device.value, "throughput", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      encrypted             = true
      kms_key_id            = var.kms_key_arn
    }
  }

  user_data   = var.user_data
  tags        = module.tags.tags
  volume_tags = module.tags.tags
}

resource "aws_volume_attachment" "this" {
  count = length(var.ebs_volume)

  device_name = lookup(var.ebs_volume[count.index], "device_name")
  volume_id   = aws_ebs_volume.this.*.id[count.index]
  instance_id = aws_instance.ec2instance.id
}

resource "aws_ebs_volume" "this" {
  count = length(var.ebs_volume)

  availability_zone = aws_instance.ec2instance.availability_zone
  size              = lookup(var.ebs_volume[count.index], "size")
  type              = lookup(var.ebs_volume[count.index], "type")
  iops              = lookup(var.ebs_volume[count.index], "iops", null)
  throughput        = lookup(var.ebs_volume[count.index], "throughput", null)
  snapshot_id       = lookup(var.ebs_volume[count.index], "snapshot_id", null)
  encrypted         = true
  kms_key_id        = var.kms_key_arn

  tags = module.tags.tags
}
