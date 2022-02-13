<template id="modal-template">
	<transition-root as="template" :show="open">
		<dialog-container as="div" auto-reopen="true" class="fixed z-40 inset-0 overflow-hidden" :open="open"
			@close="setOpen(false)">
			<div class="flex items-center justify-center min-h-screen p-2 sm:p-0">
				<transition-child as="template" enter="ease-out duration-300" enter-from="opacity-0"
					enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
					<dialog-overlay class="fixed inset-0 bg-zinc-500 bg-opacity-75 transition-opacity" />
				</transition-child>

				<!-- This element is to trick the browser into centering the modal contents. -->
				<span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
				<transition-child as="template" enter="ease-out duration-300"
					enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
					enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200"
					leave-from="opacity-100 translate-y-0 sm:scale-100"
					leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
					<div class="
							inline-block
							align-bottom
							bg-white
							rounded-lg
							m-1
							text-left
							overflow-hidden
							shadow-xl
							transform
							transition-all
							sm:my-6 sm:align-middle sm:max-w-2xl sm:w-full
						">
						<div class="p-4 sm:p-6">
							<dialog-title as="h3" class="text-lg leading-6 font-medium text-zinc-900">
								<slot name="title">Title</slot>
							</dialog-title>
						</div>
						<slot>Content</slot>
						<div class="p-4 sm:p-6 bg-zinc-100">
							<slot name="actions"><button>Actions</button></slot>
						</div>
					</div>
				</transition-child>
			</div>
		</dialog-container>
	</transition-root>
</template>