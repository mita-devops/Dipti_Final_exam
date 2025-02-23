import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>

      <div style={{ textAlign: "center", marginTop: "50px" }}>
        <h1>Welcome to My React App</h1>
        <h2>Created by Mita</h2>
      </div>
    </div>
  );
}

export default App;
