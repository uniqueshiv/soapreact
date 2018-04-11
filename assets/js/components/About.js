import React ,{Component} from 'react';


class About extends Component{
  operation(){
    //console.log('operation')
    this.props.history.push('/')
  }

  render(){
    return(
      <div className="Abouts">
      <h1>Hello About us</h1>

      <button onClick={this.operation.bind(this)}>Operation</button>
        </div>
    )
  }
}
export default About;
