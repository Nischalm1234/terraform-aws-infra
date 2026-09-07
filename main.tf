# ─────────────────────────────────────────
# Networking Layer
# ─────────────────────────────────────────
module "networking" {
  source = "./modules/networking"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  aws_region          = var.aws_region
}

# ─────────────────────────────────────────
# Compute Layer
# ─────────────────────────────────────────
module "compute" {
  source = "./modules/compute"

  project_name  = var.project_name
  environment   = var.environment
  instance_type = var.instance_type
  key_pair_name = var.key_pair_name

  # Fetching these IDs dynamically from the networking module!
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  web_sg_id         = module.networking.web_sg_id
  app_sg_id         = module.networking.app_sg_id
}

# ─────────────────────────────────────────
# Storage Layer
# ─────────────────────────────────────────
module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}