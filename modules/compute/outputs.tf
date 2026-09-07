output "web_instance_id" { value = aws_instance.web.id }
output "web_public_ip"   { value = aws_instance.web.public_ip }
output "web_public_dns"  { value = aws_instance.web.public_dns }

output "app_instance_id" { value = aws_instance.app.id }
output "app_private_ip"  { value = aws_instance.app.private_ip }

output "ami_id_used"     { value = data.aws_ami.ubuntu.id }