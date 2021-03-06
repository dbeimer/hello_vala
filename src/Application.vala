/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Beimer Campos <beimercampos.123@gmail.com>
 */

public class MyApp: Granite.Application{
  public MyApp(){
    Object(
        application_id:"com.github.dbeimer.hello_vala",
        flags:ApplicationFlags.FLAGS_NONE
      );
  }

  protected override void activate(){

    //activando el dark mode
    var granite_settings=Granite.Settings.get_default();
    var gtk_settings=Gtk.Settings.get_default();


    gtk_settings.gtk_application_prefer_dark_theme=granite_settings.prefers_color_scheme==Granite.Settings.ColorScheme.DARK;

    granite_settings.notify["prefers_color_scheme"].connect(()=>{
      gtk_settings.gtk_application_prefer_dark_theme=granite_settings.prefers_color_scheme==Granite.Settings.ColorScheme.DARK; 
    }); 

    var button = new Gtk.Button.from_icon_name("process-stop",Gtk.IconSize.LARGE_TOOLBAR){
      action_name="app.quit",
      tooltip_markup=Granite.markup_accel_tooltip(
        get_accels_for_action("app.quit"),
        "Quit"
        )
    };
    
    var header_bar=new Gtk.HeaderBar(){
      show_close_button=true
    };

    var title_label=new Gtk.Label(_("Notifications"));
    var show_button=new Gtk.Button.with_label(_("Show notification"));
    var show_button2=new Gtk.Button.with_label(_("Replace Notification"));

    var grid=new Gtk.Grid();
    grid.orientation=Gtk.Orientation.VERTICAL;
    grid.row_spacing=6; 
    grid.margin=12;
    grid.add(title_label);
    grid.add(show_button);
    grid.add(show_button2);



    header_bar.add(button);

    //simple action
    var quit_action=new SimpleAction("quit", null);
    add_action(quit_action);
    set_accels_for_action("app.quit",{"<Control>q","<Control>w"});

    var main_window=new Gtk.ApplicationWindow(this){
      default_height=300,
      default_width=300,
      title=_("actions")
    };

    var button_hello=new Gtk.Button.with_label(_("Click me!")){
      margin=12
    };

    button_hello.clicked.connect(()=>{
      button_hello.label=_("Hola mundo!");
      button_hello.sensitive=false;
    });

    show_button.clicked.connect(()=>{
      var notification=new Notification(_("Hello world!"));
      notification.set_icon(new ThemedIcon("process-completed"));
      notification.add_button(_("Quit"),"app.quit");
      notification.set_priority(NotificationPriority.URGENT);
      notification.set_body(_("This is my first notification!"));
      send_notification("com.github.dbeimer.hello_vala", notification);

    });

    show_button2.clicked.connect(()=>{
      var notification=new Notification(_("Hello Again"));
      notification.set_body(_("this is my second notiication"));

      send_notification("com.github.dbeimer.hello_vala",notification);
    });

    // main_window.add(label);
  
    main_window.set_titlebar(header_bar);
    main_window.add(grid);
    main_window.show_all();

    quit_action.activate.connect(()=>{
      main_window.destroy();
    });

  }

  public static int main(string[] args){
    return new MyApp().run(args);
  }
}
