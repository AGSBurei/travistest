defmodule TimemanagerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :timemanager,
    module: TimemanagerWeb.Auth.Guardian,
    error_handler: TimemanagerWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
