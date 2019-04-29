module ContentTypeHelper
  def set_xml_content_type
    @env['api.format'] = :xml
    content_type 'text/xml'
  end
end