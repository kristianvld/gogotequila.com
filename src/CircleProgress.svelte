<style>
  .container {
    display: grid;
    height: 100%;
    width: 100%;
    align-content: center;
    justify-content: center;
    font-size: 4em;
    animation: 1s slowreveal;
  }

  .icon {
    width: 3em;
  }

  @keyframes slowreveal {
    0% {
      opacity: 0;
    }
    99% {
      opacity: 0;
    }
    100% {
      opacity: 1;
    }
  }

  .animate-load {
    stroke-dasharray: 25%, 275%;
    animation: dash 1.8s infinite linear alternate-reverse,
      rotate 1s infinite linear;
  }

  @keyframes rotate {
    0% {
      stroke-dashoffset: 0;
    }
    100% {
      stroke-dashoffset: 300%;
    }
  }

  @keyframes dash {
    0% {
      stroke-dasharray: 25%, 275%;
    }
    100% {
      stroke-dasharray: 250%, 50%;
    }
  }
</style>

<div class="container">
  <div class="icon animate-load">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" stroke="#fff">
      <path d="M39 20a19 19 0 1 1-38 0 19 19 0 1 1 38 0z" />
    </svg>
  </div>
</div>
