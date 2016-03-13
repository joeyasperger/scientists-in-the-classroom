change distances in match_controller once we know what's up with that


      
      // //make all the teachers who have been hidden reappear
      // $('.panel.panel-info.teacher').css('display', 'block')



      // //make all the scientists who have been hidden reappear
      // $('.panel.panel-info.scientist').css('display', 'block') 


      <%= button_to("Match", action: "create_match", params: { scientist_id: scientist.id, teacher_id: }) %>


      <%= button_to("Match", action: "create_match", params: { scientist_id: ' + id + ', teacher_id:' + id_sorting_by +'}) %>';