data "aws_ssm_parameter" "aws_account_id" {
  name            = "/account-id"
  with_decryption = true
}