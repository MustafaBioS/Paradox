<script lang="ts">
	import { page } from "$app/state";
	import type { PageData } from "./$types";

	let { data }: { data: PageData } = $props();

	const backendUrl = import.meta.env.PUBLIC_BACKEND_URL ?? "http://localhost:3000";
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
</main>
