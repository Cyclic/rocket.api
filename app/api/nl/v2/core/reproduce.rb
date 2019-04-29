module NL
  module V2
    module Core
      class Reproduce < Grape::API

        desc 'Reproducing some case-sensitive issue'
        resource 'reproduce' do
          get do
            {case_is_good: true}
          end
        end
      end
    end
  end
end
