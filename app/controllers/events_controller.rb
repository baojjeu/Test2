class EventsController < ApplicationController
    
    before_action :set_event, :only => [ :show, :edit , :update , :destroy]
       
    
    def index
        @events = Event.page(params[:page]).per(5)
         respond_to do |format|
            format.html 
            format.xml { render :xml => @events.to_xml }
            format.json { render :json => @events.to_json }
            format.atom { @feed_title = "My event list" } # index.atom.builder
         end
    end
    
    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        if @event.save
            redirect_to events_url(@event)
            flash[:notice] = 'Event was successfully create '
        else
            render :action => :new
        end
    end
    
    def show
       
        @page_title = @event.name
    end
    
    def edit
           
    end
    
    def update
        
        
        if @event.update(event_params)
           redirect_to event_url(@event)
           flash[:notice] = 'Event was successfully update '
        else
           render :action => :edit
        end
    end
    
    def destroy
        
        @event.destroy
        
        redirect_to events_url(@event)
        flash[:alert] = 'Event was successfully deleted'
    end
    
    private
    
    def event_params
        
        params.require(:event).permit(:name, :description )
    
    end
    
    def set_event
        
        @event = Event.find(params[:id])
        
    end

end
