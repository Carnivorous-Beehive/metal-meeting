defmodule MetalMeeting.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  require Logger
  require Jason

  alias Ueberauth.Auth

  def find_or_create(%Auth{provider: :identity} = auth) do
    case validate_pass(auth.credentials) do
      :ok ->
        {:ok, get_user_info(auth)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def find_or_create(%Auth{} = auth) do
    {:ok, get_user_info(auth)}
  end

  defp get_user_info(auth) do
    user_info = basic_info(auth)

    case MetalMeeting.Accounts.get_user_by_email(user_info.email) do
      nil ->
        create_user!(user_info)

      user ->
        user
    end
  end

  defp create_user!(user_info) do
    case MetalMeeting.Accounts.create_oauth_user(%{
           username: user_info.email,
           email: user_info.email,
           password: user_info.password,
           avatar: user_info.avatar,
           name: user_info.name
         }) do
      {:ok, user} ->
        user

      {:error, err} ->
        raise err
    end
  end

  # github does it this way
  defp avatar_from_auth(%{info: %{urls: %{avatar_url: image}}}), do: image

  # facebook does it this way
  defp avatar_from_auth(%{info: %{image: image}}), do: image

  # default case if nothing matches
  defp avatar_from_auth(auth) do
    Logger.warn("#{auth.provider} needs to find an avatar URL!")
    Logger.debug(Jason.encode!(auth))
    nil
  end

  defp basic_info(auth) do
    %{
      id: auth.uid,
      name: name_from_auth(auth),
      avatar: avatar_from_auth(auth),
      email: auth.info.email,
      info: auth.info,
      password: Map.get(auth.credentials.other, :password, :crypto.strong_rand_bytes(32))
    }
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name =
        [auth.info.first_name, auth.info.last_name]
        |> Enum.filter(&(&1 != nil and &1 != ""))

      if Enum.empty?(name) do
        auth.info.nickname
      else
        Enum.join(name, " ")
      end
    end
  end

  defp validate_pass(%{other: %{password: nil}}) do
    {:error, "Password required"}
  end

  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end

  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end

  defp validate_pass(_), do: {:error, "Password Required"}
end
