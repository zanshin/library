get '/sort/:sortorder' do |so|
    puts "[INFO] Sorting display"
    @books = Book.all :order => so.to_sym.asc
    @subhead = 'All items'
    @items = @books.count
    @totalitems = @books.count
    @valuation = @books.sum(:purchase_price)
    erb :home
end
