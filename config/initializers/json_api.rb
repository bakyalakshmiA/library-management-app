ActiveSupport.on_load(:Action_controller) do
  require ‘active_model_serializers/register_jsonapi_renderer’
end
ActiveModelSerializers.config.adapter = :json_api