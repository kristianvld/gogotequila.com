<script>
  import CircleProgress from "./CircleProgress.svelte";
  import ClickIndicator from "./ClickIndicator.svelte";

  export var playlist;
  var currentI = Math.floor(Math.random() * playlist.length);
  //currentI = 4;
  var current = playlist[currentI % playlist.length];
  var loading = true;
  var started = false;
  var currentState = { state: -1, time: new Date() };

  var PlayerState = {
    UNSTARTED: -1,
    ENDED: 0,
    PLAYING: 1,
    PAUSED: 2,
    BUFFERING: 3,
    CUED: 5
  };

  // 2. This code loads the IFrame Player API code asynchronously.
  var tag = document.createElement("script");

  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName("script")[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // 3. This function creates an <iframe> (and YouTube player)
  //    after the API code downloads.
  var player;
  window.onYouTubeIframeAPIReady = function() {
    loading = false;
    player = new YT.Player("player", {
      videoId: current.id,
      events: {
        onReady: onPlayerReady,
        onStateChange: onPlayerStateChange
      },
      playerVars: {
        autoplay: 1,
        color: "white", // helps withi hiding the player
        controls: 0, // 0 hide video controls
        disablekb: 1, // disable keyboard
        enablejsapi: 1, // enable JS API
        fs: 0, // disable Fullscreen
        iv_load_policy: 4, // disable annotations
        modestbranding: 1 // 1 disables modest branding
      }
    });
  };

  function playNextVideo() {
    console.log("loading new video...");
    currentI++;
    currentI %= playlist.length;
    current = playlist[currentI];
    var next = { videoId: current.id };
    if (current.start) next.startSeconds = current.start;
    if (current.end) next.endSeconds = current.end;
    player.loadVideoById(next);
  }

  // 4. The API will call this function when the video player is ready.
  function onPlayerReady(event) {
    event.target.playVideo();
  }

  // 5. The API calls this function when the player's state changes.
  //    The function indicates that when playing a video (state=1),
  //    the player should play for six seconds and then stop.
  function onPlayerStateChange(event) {
    console.log("player state:", event.data, currentState);
    switch (event.data) {
      case PlayerState.BUFFERING: // 3
        break;
      case PlayerState.ENDED: // 0
        playNextVideo();
        break;
      case PlayerState.PLAYING: // 1
        break;
      case PlayerState.PAUSED: // 2
        if (currentState.time.getTime() + 1 < new Date().getTime()) {
          player.playVideo();
        }
        break;
      case PlayerState.UNSTARTED: // -1
      case PlayerState.CUED: // 5
      default:
        break;
    }
    loading = event.data == PlayerState.BUFFERING;
    started = event.data == PlayerState.PLAYING;
    if (started) {
      console.log(player);
      document.getElementById("player").classList.add("shown");
    } else {
      document.getElementById("player").classList.remove("shown");
    }
    currentState = { state: event.data, time: new Date() };
  }
</script>

{#if loading}
  <CircleProgress />
{:else if !started}
  <ClickIndicator
    on:click={e => {
      console.log('click');
      if (currentState.click && currentState.click.getTime() + 1000 < new Date().getTime()) {
        playNextVideo();
      } else {
        currentState.time = new Date(0);
        currentState.click = new Date();
        player.playVideo();
      }
    }} />
{/if}
<div id="player" class="hidden" />
