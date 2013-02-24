require "rubygems"
require "sinatra"
require "data_mapper"

# database setup
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/library.db")
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
DataMapper.finalize.auto_upgrade!

# index action
get '/' do 
    @books = Book.all :order => :id.desc
    # puts "found #{@books.count} books"
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end

# sort action
get '/sort/:sortorder' do |so|
    @books = Book.all :order => so.to_sym.asc
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end

# search action
get '/search' do
    @books = Book.all(:composer.like => "%#{params[:query]}%") | 
             Book.all(:composition.like => "%#{params[:query]}%") |
             Book.all(:edition.like => "%#{params[:query]}%") |
             Book.all(:type.like => "%#{params[:query]}%")
    @subhead = "Search results for '#{params[:query]}'"
    @items = @books.count
    @allbooks = Book.all
    @totalitems = @allbooks.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end


# show add pag
get '/add' do
    # puts "adding new book"
    @subhead = "Add item"
    erb :add
end

#post action (add)
post '/' do 
    b = Book.new
    b.type = params[:type]
    b.composer = params[:composer]
    b.composition = params[:composition]
    b.edition = params[:edition]
    b.editor = params[:editor]
    b.purchase_price = params[:price]
    b.created_at = Time.now.to_date.to_s
    b.updated_at = Time.now.to_date.to_s
    
    if b.save
        puts "the item says it saved"
    else
        puts "something went wrong and it didn't really save: #{b.to_s}"
    end

    redirect '/'
end

# edit action
get '/:id' do 
    @book = Book.get params[:id]
    @subhead = "Edit item"
    erb :edit
end

# # put (update) action
put '/:id' do 
    b = Book.get params[:id]
    b.type = params[:type]
    b.composer = params[:composer]
    b.composition = params[:composition]
    b.edition = params[:edition]
    b.editor = params[:editor]
    b.purchase_price = params[:price]
    b.updated_at = Time.now.to_date.to_s
    b.save
    redirect '/'
end

# delete action
get '/:id/delete' do 
    @book = Book.get params[:id]
    @subhead = "Confirm deletion of ##{params[:id]}"
    erb :delete
end

delete '/:id' do 
    b = Book.get params[:id]
    b.destroy
    redirect '/'
end
