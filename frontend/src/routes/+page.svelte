<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";
    import { onMount } from "svelte";

	let { data }: { data: PageData } = $props();

	const backendUrl = import.meta.env.PUBLIC_BACKEND_URL ?? "http://localhost:3000";

	let open = $state(false);

    onMount(() => {
        requestAnimationFrame(() => {
            open = true;
        });
    });

</script>

<main>
	<h1>Sign in to Paradox</h1>

	{#if data.user}
		<p>Signed in as {data.user.name}</p>
		<a href="{backendUrl}/auth/logout">Sign out</a>
	{:else}
		{#if page.url.searchParams.get("error")}
			<p>Authentication error. Please try again.</p>
		{/if}
		<a href="{backendUrl}/auth/login">Sign in with Hack Club</a>
	{/if}

	<div class="allCon font-mono">

		<div class:open={open} class="fixed inset-0 flex z-50 pointer-events-none">
		<div class="curtain left w-6/12 h-full transition-all duration-[1600ms] ease-in-out"></div>
		<div class="curtain right w-6/12 h-full transition-all duration-[1600ms] ease-in-out"></div>
		</div>

		<div class="w-full h-full absolute z-0 bg-gradient-to-t from-[#111] to-[#222] flex items-center justify-center flex-col">
			<img src="/images/Paradox.png" alt="Paradox Logo" class="w-[clamp(24rem,45vw,120rem)]">
			<h1 class="text-white text-3xl text-center mt-10">Build story-driven projects for 35 hours<br>
				Go to a 4 day in-person Game Jam in a london theatre
			</h1>
			<button class="mt-10 h-[clamp(3.2rem,6vw,_3.5rem)] w-[clamp(8.8rem,10vw,_11rem)] text-xl rounded-xl bg-white transition ease-in-out duration-350 hover:bg-black hover:text-white cursor-pointer">RSVP</button>
		</div>
		
	</div>

</main>

<style>

    .curtain {
        background:
        repeating-linear-gradient(
        to right,
        #7b0000 0px,
        #8f0000 20px,
        #7b0000 40px
        );
        box-shadow: inset -20px 0 40px rgba(0,0,0,0.5);
    }

    .right {
        box-shadow: inset 20px 0 40px rgba(0,0,0,0.5);
    }

    .left {
        transform: translateX(0);
    }

    .right {
        transform: translateX(0);
    }

    .open .left {
        transform: translateX(-100%);
    }

    .open .right {
        transform: translateX(100%);
    }

</style>