# <ul class="relative z-10 flex items-center gap-4 px-4 sm:px-6 lg:px-8 justify-end">
#       <%= if @current_account do %>
#         <li class="text-[0.8125rem] leading-6 text-zinc-900">
#           {@current_account.email}
#         </li>
#         <li>
#           <.link
#             href={~p"/accounts/settings"}
#             class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
#           >
#             Settings
#           </.link>
#         </li>
#         <li>
#           <.link
#             href={~p"/accounts/log_out"}
#             method="delete"
#             class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
#           >
#             Log out
#           </.link>
#         </li>
#       <% else %>
#         <li>
#           <.link
#             href={~p"/accounts/register"}
#             class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
#           >
#             Register
#           </.link>
#         </li>
#         <li>
#           <.link
#             href={~p"/accounts/log_in"}
#             class="text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
#           >
#             Log in
#           </.link>
#         </li>
#       <% end %>
#     </ul>
