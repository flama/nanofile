module UploaderHelper
  def uploader_for(name, attributes = {})
    presign = Nanofile.presign
    uploadable = attributes[:uploadable]

    component_for "#{name}_uploader",
      image_url: uploadable.try("#{name}_url"),
      image_cache: uploadable.try("cached_#{name}_data"),
      field_name: "#{uploadable.class.model_name.singular}[#{name}]",
      presign: {
        url: presign.url,
        fields: presign.fields
      }
  end
end
