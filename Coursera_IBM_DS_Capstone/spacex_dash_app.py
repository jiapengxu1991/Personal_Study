# Import required libraries
import pandas as pd
import dash
import dash_html_components as html
import dash_core_components as dcc
from dash.dependencies import Input, Output
import plotly.express as px

# Read the airline data into pandas dataframe
spacex_df = pd.read_csv("spacex_launch_dash.csv")
max_payload = spacex_df['Payload Mass (kg)'].max()
min_payload = spacex_df['Payload Mass (kg)'].min()

# Create a dash application
app = dash.Dash(__name__)

# Create an app layout
app.layout = html.Div(children=[html.H1('SpaceX Launch Records Dashboard',
                                        style={'textAlign': 'center', 'color': '#503D36',
                                               'font-size': 40}),
                                # TASK 1: Add a dropdown list to enable Launch Site selection
                                # The default select value is for ALL sites
                                dcc.Dropdown(
                                    id='site-dropdown',
                                    options=[
                                        {'label': 'All Sites', 'value': 'ALL'},
                                        {'label': 'CCAFS LC-40', 'value': 'CCAFS LC-40'},
                                        {'label': 'VAFB SLC-4E', 'value': 'VAFB SLC-4E'},
                                        {'label': 'KSC LC-39A', 'value': 'KSC LC-39A'},
                                        {'label': 'CCAFS SLC-40', 'value': 'CCAFS SLC-40'}],
                                    value='ALL',
                                    placeholder = 'Select a Launch Site here',
                                    searchable=True),
                                html.Br(),

                                # TASK 2: Add a pie chart to show the total successful launches count for all sites
                                # If a specific launch site was selected, show the Success vs. Failed counts for the site
                                html.Div(dcc.Graph(id='success-pie-chart')),
                                html.Br(),

                                html.P("Payload range (Kg):"),
                                # TASK 3: Add a slider to select payload range
                                dcc.RangeSlider(
                                    id='payload-slider',
                                    min = min_payload,
                                    max = max_payload,
                                    step = 1000,
                                    value = [min_payload, max_payload]
                                ),
                                # TASK 4: Add a scatter chart to show the correlation between payload and launch success
                                html.Div(dcc.Graph(id='success-payload-scatter-chart')),
                                ])

# TASK 2:
# Add a callback function for `site-dropdown` as input, `success-pie-chart` as output
@app.callback(
    Output(component_id = 'success-pie-chart', component_property = 'figure'), 
    Input(component_id = 'site-dropdown', component_property = 'value'))
def generate_chart(site_name):
    if site_name == 'ALL':
        spacex_df_pie = spacex_df[spacex_df['class'] == 1] 
        fig = px.pie(spacex_df_pie, values='class', names='Launch Site',
            title='Successful landing for all sites')
    else:
        spacex_df_pie_temp = spacex_df[spacex_df['Launch Site'] == site_name]
        spacex_df_pie_temp['Status'] = ['Success' if launch_sta == 1 else 'Fail' for launch_sta in spacex_df_pie_temp['class']]
        spacex_df_pie = spacex_df_pie_temp.groupby('Status').count()[['class']]
        spacex_df_pie.reset_index(inplace = True)
        fig = px.pie(spacex_df_pie, values='class', names='Status',
            title='Success and Fail counts for '+str(site_name))
    return fig
# TASK 4:
# Add a callback function for `site-dropdown` and `payload-slider` as inputs, `success-payload-scatter-chart` as output
@app.callback(
    Output(component_id = 'success-payload-scatter-chart', component_property = 'figure'), 
    [Input(component_id = 'site-dropdown', component_property = 'value'),
    Input(component_id = 'payload-slider', component_property = 'value')])
def generate_scatter(site_name, slider_payloads):
    low, high = slider_payloads
    mask = (spacex_df['Payload Mass (kg)'] > low) & (spacex_df['Payload Mass (kg)'] < high)
    spacex_df_scatter_temp = spacex_df[mask]

    if site_name == 'ALL':
        spacex_df_scatter = spacex_df_scatter_temp[:]
        title = 'Payload Mass (kg) vs. Launch Status'
    else:
        spacex_df_scatter = spacex_df_scatter_temp[spacex_df_scatter_temp['Launch Site'] == site_name]
        title='Payload Mass (kg) vs. Launch Status for '+str(site_name)

    fig = px.scatter(spacex_df_scatter, x= "Payload Mass (kg)", y= "class", color= "Booster Version Category", title = title)
    return fig

# Run the app
if __name__ == '__main__':
    app.run_server()
