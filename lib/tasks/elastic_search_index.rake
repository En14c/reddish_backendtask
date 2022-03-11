task :elasticsearch_create_index => [ :environment ] do
    Message.__elasticsearch__.create_index!
    Message.import
end
