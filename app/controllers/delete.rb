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
