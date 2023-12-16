resource "google_service_account" "this" {
  account_id   = var.account_id
  display_name = var.display_name
  project      = var.project
}

resource "google_service_account_key" "this" {
  count              = var.account_key ? 1 : 0
  service_account_id = google_service_account.this.name
}

resource "google_project_iam_member" "this" {
  for_each = var.roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.this.email}"
}