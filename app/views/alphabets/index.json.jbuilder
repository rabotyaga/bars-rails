json.array!(@alphabets) do |alphabet|
  json.extract! alphabet, :id, :nr, :letter, :nv, :name, :transcription, :ar_name, :ar_name_transcription, :has_all_writings
  json.url alphabet_url(alphabet, format: :json)
end
