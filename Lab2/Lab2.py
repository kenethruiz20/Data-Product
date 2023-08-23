import streamlit as st
import pandas as pd
import plotly.graph_objects as go
import folium
from streamlit_folium import folium_static

st.set_page_config(page_title="Análisis de Ventas")
st.header('Análisis de Ventas de Tienda')
st.subheader('Exploración interactiva de datos de ventas')

# Ruta del archivo CSV
file_path = r'C:\Users\Keneth Ruiz\OneDrive\Documentos\GitHub\Data-Product\Lab2\tienda.csv'

# Leer el archivo CSV con la codificación 'Windows-1252'
data = pd.read_csv(file_path, encoding='windows-1252')

# Convertir "Order Date" a datetime
data["Order Date"] = pd.to_datetime(data["Order Date"])

# Filtro de fechas
selected_dates = st.date_input("Seleccione un rango de fechas", [data["Order Date"].min().date(), data["Order Date"].max().date()])

# Otros filtros
selected_category = st.selectbox("Filtrar por categoría", data["Category"].unique())
selected_subcategory = st.selectbox("Filtrar por subcategoría", data[data["Category"] == selected_category]["Sub-Category"].unique())
selected_segment = st.selectbox("Filtrar por segmento", data["Segment"].unique())
selected_city = st.selectbox("Filtrar por ciudad", data["City"].unique())
# Agregar más filtros según las columnas que tenga tu dataset

# Leer el archivo CSV con las coordenadas
zip_map = pd.read_csv("zip_map.csv", encoding="ISO-8859-1")

# Hacer un merge usando "Postal Code" de data y "ZIP" de zip_map
data = data.merge(zip_map, left_on="Postal Code", right_on="ZIP", how="left")

# Filtrar los datos según las selecciones
filtered_data = data[(data["Order Date"] >= pd.Timestamp(selected_dates[0])) & (data["Order Date"] <= pd.Timestamp(selected_dates[1]))]
filtered_data = filtered_data[filtered_data["Category"] == selected_category]
filtered_data = filtered_data[filtered_data["Sub-Category"] == selected_subcategory]
filtered_data = filtered_data[filtered_data["Segment"] == selected_segment]
filtered_data = filtered_data[filtered_data["City"] == selected_city]
# Aplicar más filtros aquí

# Resumen de ventas
summary_table = pd.DataFrame({
    "Ventas Totales": [filtered_data["Sales"].sum()],
    "Cantidad Total": [filtered_data["Quantity"].sum()],
    "Descuentos Totales": [filtered_data["Discount"].sum()],
    "Profit Total": [filtered_data["Profit"].sum()]
})

# Mostrar la tabla de resumen
st.table(summary_table)

# Gráfico de ventas por fecha (gráfico de barras)
fig = go.Figure(data=go.Bar(x=summary_table.columns, y=summary_table.iloc[0]))
fig.update_layout(title="Resumen de Ventas")
st.plotly_chart(fig)

# Mapa de ventas por ciudad
map_data = filtered_data.groupby("City").agg({"Sales": "sum", "LAT": "mean", "LNG": "mean"}).reset_index()

m = folium.Map(location=[map_data["LAT"].mean(), map_data["LNG"].mean()], zoom_start=4)
for idx, row in map_data.iterrows():
    folium.CircleMarker(
        location=[row["LAT"], row["LNG"]],
        radius=row["Sales"] / 5000,
        color="blue",
        fill=True,
        fill_color="blue",
        fill_opacity=0.6,
        popup=f"{row['City']}<br>Ventas: ${row['Sales']:.2f}"
    ).add_to(m)

st.write("Mapa de Ventas por Ciudad")
folium_static(m)