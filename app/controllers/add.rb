# show add page
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
        puts "[INFO] The item was saved"
    else
        puts "[ERROR] Something went wrong and it didn't really save: #{b.to_s}"
    end

    redirect '/'
end
