<script>
  export var playlist;
  var currentI = Math.floor(Math.random() * playlist.length) % playlist.length;
  //currentI = 4;
  var current = playlist[currentI];
  var loading = true;
  var started = false;

  // 2. This code loads the IFrame Player API code asynchronously.
  var tag = document.createElement("script");

  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName("script")[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // 3. This function creates an <iframe> (and YouTube player)
  //    after the API code downloads.
  var player;
  var state;
  window.onYouTubeIframeAPIReady = function() {
    loading = false;
    player = new YT.Player("player", {
      videoId: current.id,
      events: {
        onReady: onPlayerReady,
        onStateChange: onPlayerStateChange
      },
      playerVars: {
        controls: 0,
        rel: 0,
        fs: 0,
        disablekb: 0,
        modestbranding: 0,
        iv_load_policy: 0
      }
    });
  };

  // 4. The API will call this function when the video player is ready.
  function onPlayerReady(event) {
    event.target.playVideo();
    console.log(event.target);
    loading = false;
    setInterval(() => {
      if (started) return;
      if (player.getPlayerState() != 1) {
        player.playVideo();
      } else {
        started = true;
        document.getElementById("player").classList.add("shown");
      }
    }, 100);
  }

  // 5. The API calls this function when the player's state changes.
  //    The function indicates that when playing a video (state=1),
  //    the player should play for six seconds and then stop.
  function onPlayerStateChange(event) {
    if (event.data == 1) {
      document.getElementById("player").classList.add("shown");
    }
    if (event.data == 0) {
      document.getElementById("player").classList.remove("shown");
      currentI++;
      currentI %= playlist.length;
      current = playlist[currentI];
      var next = { videoId: current.id };
      if (current.start) next.startSeconds = current.start;
      if (current.end) next.endSeconds = current.end;
      player.loadVideoById(next);
      console.log("queued video");
    }
  }
</script>

<style>
  .container {
    display: grid;
    height: 100%;
    width: 100%;
    align-content: center;
    justify-content: center;
    font-size: 4em;
  }

  .icon {
    width: 3em;
  }

  .animate-load {
    stroke-dasharray: 10, 110;
    animation: dash 1.5s infinite linear alternate-reverse,
      rotate 1s infinite linear;
  }

  @keyframes rotate {
    0% {
      stroke-dashoffset: 0;
    }
    100% {
      stroke-dashoffset: 120;
    }
  }

  @keyframes dash {
    0% {
      stroke-dasharray: 10, 110;
    }
    100% {
      stroke-dasharray: 100, 20;
    }
  }

  .animate-bob {
    animation: bob 1.7s ease infinite;
  }

  @keyframes bob {
    0% {
      width: 3em;
    }
    40% {
      width: 3em;
    }
    60% {
      width: 2.5em;
    }
    70% {
      width: 2.7em;
    }
    80% {
      width: 2.5em;
    }
    100% {
      width: 3em;
    }
  }
</style>

{#if loading}
  <div class="container">
    <div class="icon animate-load">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" stroke="#fff">
        <path d="M39 20a19 19 0 1 1-38 0 19 19 0 1 1 38 0z" />
      </svg>
    </div>
  </div>
{:else if !started}
  <div class="container">
    <div class="icon animate-bob">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" fill="#fff">
        <path
          d="M 13 1 C 9.691 1 7 3.691 7 7 C 7 8.771 7.776 10.360937 9 11.460938
          L 9 7 C 9 4.794 10.794 3 13 3 C 15.206 3 17 4.794 17 7 L 17 11.460938
          C 18.224 10.361937 19 8.772 19 7 C 19 3.691 16.309 1 13 1 z M 12.875
          5.0039062 C 11.828295 5.0684648 11 5.936875 11 7 L 11 22 C 8.448
          20.701 7.4050313 20 5.2070312 20 C 4.2070312 20 3 20.443266 3
          21.572266 L 3 22 L 8 25 L 11.357422 27.685547 C 12.421422 28.536547
          13.742469 29 15.105469 29 L 22 29 C 24.209 29 26 27.209 26 25 L 26 23
          L 26 17.5 C 26 16.709 25.382797 16.027953 24.591797 16.001953 C
          24.171797 15.987953 23.861813 16.070359 23.632812 16.193359 C
          23.274812 16.385359 22.830234 16.222906 22.615234 15.878906 C
          22.330234 15.421906 21.84 15 21 15 C 20.5 15 20.114172 15.141312
          19.826172 15.320312 C 19.470172 15.542312 19.021406 15.384578
          18.816406 15.017578 C 18.533406 14.508578 18 14 17 14 C 16.379 14
          15.932094 14.204219 15.621094 14.449219 C 15.369094 14.647219 15
          14.449906 15 14.128906 L 15 7.1074219 C 15 6.1114219 14.318937
          5.1873438 13.335938 5.0273438 C 13.179312 5.0019688 13.024529
          4.9946836 12.875 5.0039062 z" />
      </svg>
    </div>
  </div>
{/if}
<div id="player" class="hidden" />
