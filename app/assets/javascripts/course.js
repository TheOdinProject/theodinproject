var elements = document.getElementsByClassName('show_learning_outcomes')
  for(var i=0;i<elements.length;++i){
    elements[i].onclick = (event) => { 
      var id = event.target.id; 
      id = id.replace("p","div");
      var el = document.getElementById(id);
      el.onclick = (eventDiv) => {
        eventDiv.preventDefault();
        if(eventDiv.target.nextElementSibling) {
          var answer = eventDiv.target.nextElementSibling;
          eventDiv.target.style.outline = "none";
          eventDiv.target.style.textDecoration = "underline";
          eventDiv.target.style.textDecorationColor = "darkCyan";
          eventDiv.target.innerText = answer.innerText;
        }
        else {
          eventDiv.target.style.outline = "none";
          eventDiv.target.style.textDecoration = "underline";
          eventDiv.target.style.textDecorationColor = "darkCyan";
        }
      }
      if(event.target.innerText == "+"){
        el.style.display = 'block';
        event.target.innerText = "-";
        event.target.style.color = "red";
        event.target.title = "hide learning outcomes";
      }
      else{
        el.style.display = 'none';
        event.target.innerText = "+";
        event.target.style.color = "lime";
        event.target.title = "show learning outcomes";
      }
    }  
  }