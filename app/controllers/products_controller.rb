class ProductsController < ApplicationController
  layout "naked"
  
  def index
    respond_to do |format|
      format.html
      format.json  {
        @products = Product.find(:all)
        data = GridData.new() 
        data.set_records(@products)        
        render :json => data 
      }      
    end    
  end
  
  def show
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @product }
    end
  end
  
  def cert
    product = Product.find(params[:id])      
    render :text => product.cert.certificateString 
  end
  
  def tree
    root = nil
    id = params[:id]
    if id == "0"
      products = Product.find(:all)
      root = TreeNode.new(:id => 0, :data => "Products", :state => "open")
      products.each do |prod|
        root <<  TreeNode.new(:data => prod.name, :state => "closed", :id => "prod_"+prod.id)
      end
    else
      if id.match("prod_")
        id = id.sub("prod_", "")
        prod = Product.find(id)
        root = []
        if prod.product_attributes.size > 0 
          attrNode = TreeNode.new(:state => "closed", :data => "Attributes", :id => "attrs_"+id)
          prod.product_attributes.each() do |a|
            dataNode = TreeNode.new(:id => a.id, :data => a.name + " => " + a.value)
            attrNode << dataNode
          end
          root << attrNode        
        end
        if prod.content.size > 0
          contentNode = TreeNode.new(:state => "closed", :data => "Content", :id => "cont_"+id)
          prod.content.each() do |c|
            dataNode = TreeNode.new(:id => c.id, :data => c.contentUrl)
            contentNode << dataNode
          end   
          root << contentNode         
        end
        prod.childProducts.each do |p|
          root <<  TreeNode.new(:data => p.name, :state => "closed", :id => "prod_"+p.id)          
        end
      end
    end
    render :json => root
  end
 
end
