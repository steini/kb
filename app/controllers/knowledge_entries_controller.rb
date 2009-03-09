class KnowledgeEntriesController < ApplicationController

  layout "application", :except => [:rss]

  def index
    @knowledge_entries = KnowledgeEntry.recent
    @tags = Tag.find(:all)
  end

  def rss
    @knowledge_entries = KnowledgeEntry.recent
  end

  def new
    @knowledge_entry = KnowledgeEntry.new
  end

  def show
    @knowledge_entry = KnowledgeEntry.find_by_id(params[:id])
  end

  def create

    tags = params[:knowledge_entry].delete(:tags)

    @knowledge_entry = KnowledgeEntry.new(params[:knowledge_entry])
    @knowledge_entry.tag_list = tags

    if !@knowledge_entry.save
      render :action => "new"
    else
      flash[:notice] = "knowledge successfully created!"
      redirect_to "/"
    end
  end

  def edit
    if current_user.nil?
      flash[:notice] = "you must be loggedin, in order to update knowledge"
      redirect_to("/")
    end
    @knowledge_entry = KnowledgeEntry.find(params[:id])
  end

  def update
    if current_user.nil?
      flash[:notice] = "you must be loggedin, in order to update knowledge"
      redirect_to("/") and return
    end
    @knowledge_entry = KnowledgeEntry.find(params[:id])
    @knowledge_entry.tag_list = params[:knowledge_entry][:tags]

    if @knowledge_entry.save

      params[:knowledge_entry].delete(:tags)

      if @knowledge_entry.update_attributes(params[:knowledge_entry])
        flash[:notice] = "knowledge successfully updated!"
        redirect_to "/" and return
      else
        render :action => "edit"
      end
    else
      render :action => "edit"
    end
  end

  def delete
    if current_user.nil?
      flash[:notice] = "you must be loggedin, in order to delete knowledge"
      redirect_to("/") and return
    end
    knowledge_entry = KnowledgeEntry.find(params[:id])
    if knowledge_entry.destroy
      flash[:notice] = "knowledge successfully deleted!"
      redirect_to "/"
    end
  end

  def tag

    @knowledge_entries = KnowledgeEntry.tagged_with(Tag.find(params[:tag]), :on => :tags)
    @tags = Tag.find(:all)

    render :action => 'index'
  end

  def search

    page = params[:page] || 1

    knowledge_entry_ids = KnowledgeEntry.search_for_ids(
      params[:q].to_s,
      :match_mode => :any,
      :per_page => 10,
      :page => page,
      :order => "created_at DESC"
    )

    @total_entries = knowledge_entry_ids.total_entries
    @total_pages = knowledge_entry_ids.total_pages
    @current_page = knowledge_entry_ids.current_page
    @per_page = knowledge_entry_ids.per_page

    @knowledge_entries = KnowledgeEntry.find(knowledge_entry_ids)
  end

end
