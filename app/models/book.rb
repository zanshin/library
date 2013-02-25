#
class Book
    include DataMapper::Resource
    
    property :id, Serial
    property :type, String, :length => 25, :required => true
    property :composer, String, :length =>75, :required => true
    property :composition, Text, :required => true
    property :edition, String, :length => 40, :required => true
    property :editor, String, :length => 40
    property :purchase_price, Decimal, :precision => 10, :scale => 2
    property :created_at, Date
    property :updated_at, Date

    def to_s
      "Book{id: #{id}, type: #{type}, composer: #{composer}, composition: #{composition}, edition: #{edition}, editor: #{editor}, price: #{purchase_price}}"
    end
end
