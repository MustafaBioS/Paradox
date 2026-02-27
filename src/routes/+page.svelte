<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";
    import { onMount } from "svelte";

	let { data }: { data: PageData } = $props();

	const apiBase = "/api";

	let open = $state(false);

    onMount(() => {
        requestAnimationFrame(() => {
            open = true;
        });
    });
</script>

<main>
<!--	<h1>Sign in to Paradox</h1>-->

<!--	{#if data.user}-->
<!--		<p>Signed in as {data.user.name}</p>-->
<!--		<a href="{apiBase}/auth/logout">Sign out</a>-->
<!--	{:else}-->
<!--		{#if page.url.searchParams.get("error")}-->
<!--			<p>Authentication error. Please try again.</p>-->
<!--		{/if}-->
<!--		<a href="{apiBase}/auth/login">Sign in with Hack Club</a>-->
<!--	{/if}-->

	<div class="w-screen h-screen relative bg-black flex justify-start items-start z-50">

		<img src="/images/Stage.png"
			 class="absolute inset-0 w-full h-full object-contain z-0"
			 alt="Stage" />

		<img src="/images/Curtain.png"
			 class="absolute left-0 top-0 h-full object-contain z-10"
			 alt="Left Curtain" />

		<img src="/images/Curtain.png"
			 class="absolute right-0 top-0 h-full object-contain z-10 scale-x-[-1]"
			 alt="Right Curtain" />

		<img src="/images/Sign.png"
			 class="absolute right-0 top-0 h-full object-contain z-20 transition duration-300 hover:opacity-60 cursor-pointer"
			 alt="Sign" />

		<img src="/images/Logo.png"
			 class="absolute w-5/12 h-5/12 top-[14.3rem] left-1/2 -translate-x-1/2 object-contain z-30"
			 alt="Logo" />

	</div>

</main>