module AccountingItemsHelper
  def image_card_tag image, options = {}
    options[:url]= rails_storage_proxy_path(image)
    options[:thumb]= rails_storage_proxy_path(image.variant(:thumb))
    options[:size]= number_to_human_size(image.byte_size)
    options[:uploaded]= time_ago_in_words(image.created_at)
    options[:tag]= "NEW" if ((DateTime.now - image.created_at.to_datetime) * 24 * 60).to_i < 60
    options[:image_name]= image.filename.to_s
    
    options[:view_text]= "Посмотреть"
    options[:download_text]= "Скачать"
    options[:delete_text]= "Удалить"
    options[:size_text]= "Размер"
    options[:uploaded_text]= "Загружено"

    content_tag :"image-card", nil, **options
  end
end
