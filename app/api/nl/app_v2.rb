module NL
  class AppV2 < Grape::API
    version 'v1', using: :path

    desc 'User\'s Resources Management', {headers: {'X-NL-Auth-Token' => {required: true}}}
    before {authenticate!}

    mount ::NL::V2::Core::Reproduce

  end
end
