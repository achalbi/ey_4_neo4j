class UsersController < ApplicationController
autocomplete :location, :address, :full => true

  def login
    oauth = request.env["omniauth.auth"]
    @user = User.find_by(uid: oauth['uid'])
    #session['fb_auth'] = oauth

    if  @user.nil?
      @user = User.create_with_omniauth(oauth)
    end
    unless  @user.username.present? 
      @user = update_with_omniauth(@user, oauth)
    end
    @user.fb_access_token = oauth['credentials']['token']
    session['fb_access_token'] = oauth['credentials']['token']
    session['fb_error'] = nil
    @user.save!
    
    #debugger
    @graph = Koala::Facebook::API.new(@user.fb_access_token)
    @friends = @graph.get_connections("me", "friends")
    @user.friends_list = @friends
    @user.save!
    sign_in @user
    
    create_fb_friends(@user.uid, @friends)
    sign_in @user
    redirect_to root_path
  end

  def friends
    @friends = []
    unless current_user.gender == 'male'
        #@friends = current_user.friend_boys.paginate(:page => params[:page], :per_page => 8)
        @friends = current_user.friend_boys.limit(8)
    else
        @friends = current_user.friend_girls.limit(8)
    end
  end

  def page_friends
        @friends = []
    unless current_user.gender == 'male'
        @friends = current_user.friend_boys.skip((8) * params[:page].to_i-8).limit(8)
    else
        @friends = current_user.friend_girls.skip((8) * params[:page].to_i-8).limit(8)
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def autocomplete_location_address
    gc = Geocoder.search(params[:address])
    result = gc.collect do |t|
      {value: t.address}
    end
    respond_to do |format|
      format.json {render json: result}
    end
  end

  def add_location
    gc = Geocoder.search(params[:address])[0]
      @location = Location.find_by(address: gc.address)
      if @location.nil?
          @location = Location.new
          @location.address = gc.address
          @location.latitude = gc.latitude
          @location.longitude = gc.longitude
          @location.save
      end
      if current_user.rels(type: :places, between: @location).blank?
        current_user.places << @location
        current_user.save
      end
  end

  def loc_users
    @users = current_user.places.users
    u = User.find(1158)
    loc = Location.find(1155)
    loc.places.gender_filter('female').to_a
    
  end

  def search_criteria
  @friends = []
    location_ids = params[:location_ids]#.map(&:to_i)
    session['location_ids'] = location_ids
    @friends = User.as(:u).places(:l).where(address: location_ids).limit(2).pluck('DISTINCT u')
    #query = Neo4j::Session.query.match(u: :User, l: :Location)
    #query = query.where('u.id' => current_user.neo_id)  
    #query = query.where('l.neo_id' => location_ids)  
    #@friends = query.where('l.id' => location_ids).pluck('DISTINCT u')
    #@friends = @friends - Array(current_user)
  end

  def page_search_criteria
     @friends = []
    location_ids = session['location_ids']
    @friends = User.as(:u).places(:l).where(address: location_ids).skip((2) * params[:page].to_i-2).limit(2).pluck('DISTINCT u')
   # @friends = @friends - Array(current_user)
  end

  def likes
    @user = User.find(params[:id])
    unless  current_user.rels(type: :likes, between: @user).blank?
      rel = current_user.rels(type: :likes, between: @user)
      rel[0].destroy
      current_user.save!
    else
      current_user.likes << @user
      current_user.save!
    end
    head :ok#, :content_type => 'text/html'
  end

end
