<script>
  var playlist = [
    {
      id: "3H6amDbAwlY",
      desc: "Tequila - The Champs"
    },
    {
      id: "77Ms1oCiDH4",
      desc: "Salsa Tequila"
    },
    {
      id: "CNLD9Qnki2o",
      desc: "Tequila - Friends"
    },
    {
      id: "KW_6XpVfgKs",
      desc: "Tequila - The Champs - Remix"
    },
    {
      id: "koTZc4gSQgk",
      desc: "Da Tweekaz - Tequila"
    }
  ];
  import Player from "./Player.svelte";

  let action = Math.random();
  if (action < 0.1) {
    window.history.pushState(null, document.title, document.location.href);
    document.location.href = "https://www.vinmonopolet.no/vmp/search/?q=tequila";
  } else if (action < 0.2) {
    window.history.pushState(null, document.title, document.location.href);
    document.location.href = "https://duckduckgo.com/?q=tequila";
  } else {
    // Do nothing, load site
  }
</script>

<style>
  main {
    text-align: center;
    max-width: 240px;
    margin: 0 auto;
    height: 100%;
    width: 100%;
  }

  h1 {
    color: #ff3e00;
    text-transform: uppercase;
    font-size: 4em;
    font-weight: 100;
  }

  img {
    max-width: 70vw;
    max-height: 75vh;
  }

  @media (min-width: 640px) {
    main {
      max-width: none;
    }
  }
</style>

<main>
  {#if false}
    <h1>Go Go Tequila!</h1>
    <p>
      Visit the
      <a href="https://svelte.dev/tutorial">Svelte tutorial</a>
      to learn how to build Svelte apps.
    </p>
    <img src="/tequila-gang.jpg" alt="Tequila Gang" />
  {/if}
  <Player {playlist} />
</main>
