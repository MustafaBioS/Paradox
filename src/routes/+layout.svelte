<script>
import "../app.css";

let { children } = $props();</script>

<svelte:head>
	<link rel="icon" href="/images/1/Mask.png" />
</svelte:head>

{@render children()}
