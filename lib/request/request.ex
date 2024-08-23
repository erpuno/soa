defmodule Soap.Request do
  @moduledoc """
  Documentation for Soap.Request.
  """
  alias Soap.Request.{Headers, Params}

  def b2l(x), do: x |> :erlang.binary_to_list

  @doc """
  Executing with parsed wsdl and headers with body map.
  Calling httpc.request by Map with method, url, body, headers, options keys.
  """
  @spec call(wsdl :: map(), operation :: String.t(), params :: any(), headers :: any(), opts :: any()) :: any()
  def call(wsdl, operation, {soap_headers, params}, request_headers, _opts) do
    url = # get_url(wsdl)
          :application.get_env(:soa, :soap_gateway, "http://10.20.60.30:80/")
          |> :erlang.binary_to_list
    request_headers = Headers.build(wsdl, operation, request_headers)
    body = Params.build_body(wsdl, operation, params, soap_headers)
    request_headers = request_headers |> (Enum.map fn {x,y} -> {b2l(x),b2l(y)} end)
    :io.format 'SOAP Endpoint: ~ts~n', [url]
    :io.format 'SOAP Params: ~p~n', [params]
    :io.format 'SOAP Request Headers: ~p~n', [request_headers]
    :io.format 'SOAP Body: ~ts~n', [body]
    :httpc.request(:post, {url, request_headers, 'text/xml;charset=utf-8', body},
                 [{:relaxed,true},{:timeout,1000}], [{:body_format,:binary}])
  end

  def call(wsdl, operation, params, request_headers, opts),
    do: call(wsdl, operation, {nil, params}, request_headers, opts)

  @spec get_url(wsdl :: map()) :: String.t()
  def get_url(wsdl) do
    wsdl.endpoint
  end
end
