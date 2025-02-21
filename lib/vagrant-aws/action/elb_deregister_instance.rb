require 'vagrant-aws/util/elb'

module VagrantPlugins
  module AWS
    module Action
      # This registers instance in ELB
      class ElbDeregisterInstance
        include ElasticLoadBalancer

        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_aws::action::elb_deregister_instance")
        end

        def call(env)
          if tg_name = env[:machine].provider_config.target_group
            elb_name = env[:machine].provider_config.elb
            deregister_instance env, elb_name, env[:machine].id, tg_name
          end
          @app.call(env)
        end
      end
    end
  end
end
